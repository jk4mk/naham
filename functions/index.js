/**
 * Naham Cloud Functions
 * - Chef rejection email: when chefApprovalStatus becomes "rejected", send email to chef.
 */

const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/**
 * Trigger: onDocumentUpdated on chefs/{chefId}
 * When chefApprovalStatus changes to "rejected":
 * - Read rejectionReason from the document
 * - Read chef email from users/{chefId}
 * - Send email (using Firebase Extensions Nodemailer or Gmail SMTP)
 *
 * For sending email you can:
 * 1. Use the "Trigger Email from Firestore" extension (recommended): write to mail collection
 * 2. Or use nodemailer with Gmail SMTP (set GMAIL_USER, GMAIL_APP_PASSWORD in config)
 * Here we use a mail collection that the extension reads, so you can install the extension
 * and this function just creates a doc in the mail collection.
 * Alternatively we use firebase-admin to send via a custom SMTP (nodemailer not included
 * by default; add it to package.json if you prefer SMTP here).
 */
exports.onChefRejected = functions.firestore
  .document("chefs/{chefId}")
  .onUpdate(async (change, context) => {
    const after = change.after.data();
    const before = change.before.data();
    const chefId = context.params.chefId;

    const statusAfter = after?.chefApprovalStatus;
    const statusBefore = before?.chefApprovalStatus;

    if (statusAfter !== "rejected" || statusBefore === "rejected") {
      return null;
    }

    const rejectionReason =
      after?.rejectionReason ||
      "لم يتم تحديد السبب.";

    let email = null;
    try {
      const userDoc = await admin.firestore().collection("users").doc(chefId).get();
      if (userDoc.exists && userDoc.data()?.email) {
        email = userDoc.data().email;
      }
    } catch (e) {
      functions.logger.warn("Failed to read user email", { chefId, error: e.message });
      return null;
    }

    if (!email) {
      functions.logger.warn("No email for chef", { chefId });
      return null;
    }

    const subject = "طلب انضمامك لتطبيق نهم";
    const body = `عزيزي الطباخ، نأسف لإبلاغك أن طلب انضمامك تم رفضه للسبب التالي: ${rejectionReason}\n\nيمكنك التواصل معنا للمزيد من المعلومات.`;

    // Option A: Write to a "mail" collection for the "Trigger Email from Firestore" extension
    try {
      await admin.firestore().collection("mail").add({
        to: email,
        message: {
          subject,
          text: body,
        },
      });
      functions.logger.info("Rejection email queued", { chefId, to: email });
    } catch (e) {
      functions.logger.error("Failed to queue rejection email", {
        chefId,
        to: email,
        error: e.message,
      });
      throw e;
    }

    return null;
  });
