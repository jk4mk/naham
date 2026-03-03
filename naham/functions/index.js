/**
 * Naham Cloud Functions
 * - Chef rejection email: when chefApprovalStatus becomes "rejected", send email to chef in Arabic.
 */

const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

/**
 * Trigger: onDocumentUpdated on chefs/{chefId}
 * When chefApprovalStatus changes to "rejected":
 * - Read rejectionReason from chefs/{chefId}
 * - Read chef email from users/{chefId}
 * - Send email to chef with rejection reason in Arabic
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

    const subject = "إشعار بخصوص طلب انضمامك لتطبيق نهم";
    const body = `عزيزي الطاهي،

نأسف لإبلاغك أن طلب انضمامك كطاهٍ في تطبيق نهم تم رفضه.

السبب: ${rejectionReason}

يمكنك التواصل معنا للمزيد من المعلومات أو إعادة التقديم بعد معالجة الملاحظات.

مع تحياتنا،
فريق نهم`;

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
