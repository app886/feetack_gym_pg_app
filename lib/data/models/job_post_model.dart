class JobPostModel {
  int? id;
  String? partnerId;
  String? createdBy;
  String? jobTitle;
  String? jobCode;
  int? departmentId;
  int? branchId;
  String? employmentType;
  String? experience;
  String? salary;
  int? vacanciesCount;
  String? referralBudget;
  String? referralAmount;
  String? banner;
  String? applicationDeadline;
  String? jobDescription;
  String? skills;
  String? status;
  String? bannerUrl;
  JobDepartment? department;
  JobBranch? branch;
  JobCreator? creator;

  JobPostModel({
    this.id,
    this.partnerId,
    this.createdBy,
    this.jobTitle,
    this.jobCode,
    this.departmentId,
    this.branchId,
    this.employmentType,
    this.experience,
    this.salary,
    this.vacanciesCount,
    this.referralBudget,
    this.referralAmount,
    this.banner,
    this.applicationDeadline,
    this.jobDescription,
    this.skills,
    this.status,
    this.bannerUrl,
    this.department,
    this.branch,
    this.creator,
  });

  JobPostModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    partnerId = json['partner_id']?.toString();
    createdBy = json['created_by']?.toString();
    jobTitle = json['job_title']?.toString();
    jobCode = json['job_code']?.toString();
    departmentId = json['department_id'] != null ? int.tryParse(json['department_id'].toString()) : null;
    branchId = json['branch_id'] != null ? int.tryParse(json['branch_id'].toString()) : null;
    employmentType = json['employment_type']?.toString();
    experience = json['experience']?.toString();
    salary = json['salary']?.toString();
    vacanciesCount = json['vacancies_count'] != null ? int.tryParse(json['vacancies_count'].toString()) : null;
    referralBudget = json['referral_budget']?.toString();
    referralAmount = json['referral_amount']?.toString();
    banner = json['banner']?.toString();
    applicationDeadline = json['application_deadline']?.toString();
    jobDescription = json['job_description']?.toString();
    skills = json['skills']?.toString();
    status = json['status']?.toString();
    bannerUrl = json['banner_url']?.toString();
    department = json['department'] != null ? JobDepartment.fromJson(json['department']) : null;
    branch = json['branch'] != null ? JobBranch.fromJson(json['branch']) : null;
    creator = json['creator'] != null ? JobCreator.fromJson(json['creator']) : null;
  }
}

class JobDepartment {
  int? id;
  String? name;
  String? description;

  JobDepartment({this.id, this.name, this.description});

  JobDepartment.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    name = json['name']?.toString();
    description = json['description']?.toString();
  }
}

class JobBranch {
  int? id;
  String? name;
  String? address;

  JobBranch({this.id, this.name, this.address});

  JobBranch.fromJson(Map<String, dynamic> json) {
    id = json['id'] != null ? int.tryParse(json['id'].toString()) : null;
    name = json['name']?.toString();
    address = json['address']?.toString();
  }
}

class JobCreator {
  String? id;
  String? name;
  String? email;
  String? mobile;
  String? workingMode;
  String? profileImageUrl;

  JobCreator({
    this.id,
    this.name,
    this.email,
    this.mobile,
    this.workingMode,
    this.profileImageUrl,
  });

  JobCreator.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    name = json['name']?.toString();
    email = json['email']?.toString();
    mobile = json['mobile']?.toString();
    workingMode = json['working_mode']?.toString();
    profileImageUrl = json['profile_image_url']?.toString();
  }
}
