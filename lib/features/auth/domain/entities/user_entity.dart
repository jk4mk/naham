import 'package:equatable/equatable.dart';

/// User role in the marketplace.
enum AppRole { chef, customer }

/// Chef application status. Only relevant when role is chef.
enum ChefApprovalStatus { pending, approved, rejected }

class UserEntity extends Equatable {
  final String id;
  final String email;
  final String name;
  final String? phone;
  final String? profileImageUrl;
  final bool isVerified;
  final AppRole? role;
  /// For chefs: pending until review, then approved or rejected.
  final ChefApprovalStatus? chefApprovalStatus;
  /// Shown on rejection screen when chefApprovalStatus == rejected.
  final String? rejectionReason;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    this.phone,
    this.profileImageUrl,
    this.isVerified = false,
    this.role,
    this.chefApprovalStatus,
    this.rejectionReason,
  });

  bool get isChef => role == AppRole.chef;
  bool get isCustomer => role == AppRole.customer;
  bool get isChefApproved => role == AppRole.chef && chefApprovalStatus == ChefApprovalStatus.approved;
  bool get isChefRejected => role == AppRole.chef && chefApprovalStatus == ChefApprovalStatus.rejected;
  bool get isChefPending => role == AppRole.chef && chefApprovalStatus == ChefApprovalStatus.pending;

  @override
  List<Object?> get props => [
        id,
        email,
        name,
        phone,
        profileImageUrl,
        isVerified,
        role,
        chefApprovalStatus,
        rejectionReason,
      ];
}
