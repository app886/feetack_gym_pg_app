class JobDetailResponse {
  bool? success;
  JobDetailData? data;

  JobDetailResponse({this.success, this.data});

  JobDetailResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? JobDetailData.fromJson(json['data']) : null;
  }
}

class JobDetailData {
  Header? header;
  JobDetailInfo? jobDetail;
  CompanyDetail? companyDetail;
  int? id;
  String? jobCode;
  dynamic referralAmount;
  String? bannerUrl;

  JobDetailData({
    this.header,
    this.jobDetail,
    this.companyDetail,
    this.id,
    this.jobCode,
    this.referralAmount,
    this.bannerUrl,
  });

  JobDetailData.fromJson(Map<String, dynamic> json) {
    header = json['header'] != null ? Header.fromJson(json['header']) : null;
    jobDetail = json['job_detail'] != null ? JobDetailInfo.fromJson(json['job_detail']) : null;
    companyDetail = json['company_detail'] != null ? CompanyDetail.fromJson(json['company_detail']) : null;
    id = json['id'];
    jobCode = json['job_code']?.toString();
    referralAmount = json['referral_amount'];
    bannerUrl = json['banner_url']?.toString();
  }
}

class Header {
  String? logoUrl;
  String? jobTitle;
  String? companyName;
  String? employmentType;
  int? applicantsCount;
  String? location;

  Header.fromJson(Map<String, dynamic> json) {
    logoUrl = json['logo_url']?.toString();
    jobTitle = json['job_title']?.toString();
    companyName = json['company_name']?.toString();
    employmentType = json['employment_type']?.toString();
    applicantsCount = json['applicants_count'];
    location = json['location']?.toString();
  }
}

class JobDetailInfo {
  Overview? overview;
  String? descriptions;
  List<String>? skills;
  List<String>? responsibilities;

  JobDetailInfo.fromJson(Map<String, dynamic> json) {
    overview = json['overview'] != null ? Overview.fromJson(json['overview']) : null;
    descriptions = json['descriptions']?.toString();
    if (json['skills'] != null) {
      skills = List<String>.from(json['skills']);
    }
    if (json['responsibilities'] != null) {
      responsibilities = List<String>.from(json['responsibilities']);
    }
  }
}

class Overview {
  String? salary;
  String? type;
  String? workMode;
  String? level;

  Overview.fromJson(Map<String, dynamic> json) {
    salary = json['salary']?.toString();
    type = json['type']?.toString();
    workMode = json['work_mode']?.toString();
    level = json['level']?.toString();
  }
}

class CompanyDetail {
  String? logoUrl;
  String? companyName;
  Details? details;

  CompanyDetail.fromJson(Map<String, dynamic> json) {
    logoUrl = json['logo_url']?.toString();
    companyName = json['company_name']?.toString();
    details = json['details'] != null ? Details.fromJson(json['details']) : null;
  }
}

class Details {
  String? website;
  String? headquarters;

  Details.fromJson(Map<String, dynamic> json) {
    website = json['website']?.toString();
    headquarters = json['headquarters']?.toString();
  }
}
