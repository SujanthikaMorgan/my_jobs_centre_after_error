// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:my_jobs_center/Screens/Add_Resume.dart';
import 'package:my_jobs_center/Screens/Chats.dart';
import 'package:my_jobs_center/Screens/Chats_Expanded.dart';
import 'package:my_jobs_center/Screens/Companies.dart';
import 'package:my_jobs_center/Screens/Company_Expanded.dart';
import 'package:my_jobs_center/Screens/Fav_Jobs.dart';
import 'package:my_jobs_center/Screens/Forget_Password_Dialogue.dart';
import 'package:my_jobs_center/Screens/Home.dart';
import 'package:my_jobs_center/Screens/HomeJob.dart';
import 'package:my_jobs_center/Screens/JobAlert.dart';
import 'package:my_jobs_center/Screens/Job_Expanded.dart';
import 'package:my_jobs_center/Screens/My_Resumes.dart';
import 'package:my_jobs_center/Screens/Profile.dart';
import 'package:my_jobs_center/Screens/Profile_Add_Experience.dart';
import 'package:my_jobs_center/Screens/Profile_LinkedAccounts.dart';
import 'package:my_jobs_center/Screens/Sign_In.dart';
import 'package:my_jobs_center/Screens/Sign_Up_jobseeker.dart';
import 'package:my_jobs_center/Screens/addLinkedAccountPage.dart';
import 'package:my_jobs_center/Screens/allJobs.dart';
import 'package:my_jobs_center/Screens/allJobsSearch.dart';
import 'package:my_jobs_center/Screens/allJobsWithFilters.dart';
import 'package:my_jobs_center/Screens/appliedJobs.dart';
import 'package:my_jobs_center/Screens/applyNowPage.dart';
import 'package:my_jobs_center/Screens/featuredJobsAll.dart';
import 'package:my_jobs_center/Screens/newPassword.dart';
import 'package:my_jobs_center/Screens/prof_changeImage.dart';
import 'package:my_jobs_center/Screens/resumePreviewPage.dart';
import 'package:my_jobs_center/Screens/splashScreen.dart';
import 'package:my_jobs_center/Screens/urgentJobAll.dart';
import 'package:my_jobs_center/employer/employer%20screens/applicants.dart';
import 'package:my_jobs_center/employer/employer%20screens/applicantsdetails.dart';
import 'package:my_jobs_center/employer/employer%20screens/createCompany.dart';
import 'package:my_jobs_center/employer/employer%20screens/employer.dart';
import 'package:my_jobs_center/employer/employer%20screens/favUsers.dart';
import 'package:my_jobs_center/employer/employer%20screens/job.dart';
import 'package:my_jobs_center/employer/employer%20screens/jobPost.dart';
import 'package:my_jobs_center/employer/employer%20screens/notselected.dart';
import 'package:my_jobs_center/employer/employer%20screens/sidemenuEmployer.dart';
import 'package:my_jobs_center/employer/widget/jobsWidget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey =
      'pk_test_51KlPvqSDvq8Arat42MJHR2yGopr469DRJDvxzjBVFQcrUzSi8yamplpNteRGDI7x9jTQpygxHPRdgmWMsiTEQ2S000dHRAGwZq';
  // Stripe.publishableKey = 'stripePublishableKey';
  Stripe.merchantIdentifier = 'merchant.flutter.stripe.test';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: () => MaterialApp(
        title: 'Flutter Demo',
        // initialRoute: SplashScreenPage.idScreen,
        initialRoute: SignIn.idScreen,
        routes: {
          Profile.idScreen: (context) => Profile(),
          Profile_LinkedAccounts.idScreen: (context) => Profile_LinkedAccounts(),
          Profile_Add_Experience.idScreen: (context) => Profile_Add_Experience(),
          HomeJob.idScreen: (context) => HomeJob(),
          JobAlert.idScreen: (context) => JobAlert(),
          // JobExpanded.idScreen: (context) => JobExpanded(),
          FavJobs.idScreen: (context) => FavJobs(),
          AppliedJobsScreen.idScreen: (context) => AppliedJobsScreen(),
          SignIn.idScreen: (context) => SignIn(),
          UrgentJobsAll.idScreen: (context) => UrgentJobsAll(),
          FeaturedJobsAll.idScreen: (context) => FeaturedJobsAll(),
          ResumePreviewPage.idScreen: (context) => ResumePreviewPage(),
          // My_Resumes.idScreen: (context) => My_Resumes(),
          AddLinkedAccountPage.idScreen: (context) => AddLinkedAccountPage(),
          Sign_Up_jobseeker.idScreen: (context) => Sign_Up_jobseeker(),
          Forget_Password_Dialogue.idScreen: (context) => Forget_Password_Dialogue(),
          NewPasswordPage.idScreen: (context) => NewPasswordPage(),
          ChatsPage.idScreen: (context) => ChatsPage(),
          AllJobsPage.idScreen: (context) => AllJobsPage(),
          AllJobsWithFilters.idScreen: (context) => AllJobsWithFilters(),
          AllJobsSearch.idScreen: (context) => AllJobsSearch(),
          SplashScreenPage.idScreen: (context) => SplashScreenPage(),
          Companies.idScreen: (context) => Companies(),
          Add_Resume.idScreen: (context) => Add_Resume(),
          Home.idScreen: (context) => Home(),
          ProfChangeImage.idScreen: (context) => ProfChangeImage(),
          // ApplyNowPage.idScreen: (context) => ApplyNowPage(),
          // Company_Expanded.idScreen: (context) => Company_Expanded(),
          //------------Employer-------------------
          SidemenuEmployer.idScreen: (context) => SidemenuEmployer(),
          // JobsWidget.idScreen: (context) => JobsWidget(
          //       jobtype: "Urgent",
          //     ),
          JobPost.idScreen: (context) => JobPost(),
          // NotSelected.idScreen: (context) => NotSelected(),
          // ApplicantDetails.idScreen: (context) => ApplicantDetails(),
          Employer.idScreen: (context) => Employer(),
          CreateCompany.idScreen: (context) => CreateCompany(),
          Job.idScreen: (context) => Job(),
          FavUsers.idScreen: (context) => FavUsers(),
        },
      ),
      designSize: const Size(360, 690),
    );
  }
}
//default_user.png
