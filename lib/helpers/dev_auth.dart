enum DevUserRole { employee, supervisor }

final class DevAuth {
  DevAuth._();

  static const String password = '123456';
  static const String employeeEmail = 'employee@gmail.com';
  static const String supervisorEmail = 'supervisor@gmail.com';

  static DevUserRole? roleForCredentials({
    required String email,
    required String password,
  }) {
    if (password != DevAuth.password) return null;

    final normalizedEmail = email.trim().toLowerCase();
    if (normalizedEmail == employeeEmail) return DevUserRole.employee;
    if (normalizedEmail == supervisorEmail) return DevUserRole.supervisor;

    return null;
  }

  static String emailForRole(DevUserRole role) {
    return switch (role) {
      DevUserRole.employee => employeeEmail,
      DevUserRole.supervisor => supervisorEmail,
    };
  }

  static String storageValueForRole(DevUserRole role) {
    return switch (role) {
      DevUserRole.employee => 'employee',
      DevUserRole.supervisor => 'supervisor',
    };
  }
}
