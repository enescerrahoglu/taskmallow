import 'package:taskmallow/constants/category_constants.dart';
import 'package:taskmallow/constants/task_situations_constants.dart';

List<ProjectModel> projects = [
  ProjectModel(
    name: "Project 1",
    category: Categories.mobile_applications,
    description:
        "TaskMallow, iş yönetimi ve inovasyonu bir araya getiren yenilikçi bir uygulamadır. Projelerinizi yönetmek, görevleri takip etmek, yaratıcı fikirler geliştirmek ve eşleşme özelliğiyle en uygun görevleri bulmak için tasarlanmıştır.",
    userWhoCreated: UserModel(
        email: "enescerrahoglu1@gmail.com",
        firstName: "Enes",
        lastName: "Cerrahoğlu",
        description: "Bilgisayar Mühendisi",
        profilePhotoURL:
            "https://firebasestorage.googleapis.com/v0/b/taskmallow-app.appspot.com/o/team%2Fenes.jpg?alt=media&token=faac91a0-5467-4c4f-ab33-6f248ba88b75"),
    tasks: [],
    collaborators: [],
  ),
  ProjectModel(
    name: "Project 2",
    category: Categories.data_analytics,
    description:
        "TaskMallow, iş yönetimi ve inovasyonu bir araya getiren yenilikçi bir uygulamadır. Projelerinizi yönetmek, görevleri takip etmek, yaratıcı fikirler geliştirmek ve eşleşme özelliğiyle en uygun görevleri bulmak için tasarlanmıştır.",
    userWhoCreated: UserModel(
        email: "enescerrahoglu1@gmail.com",
        firstName: "Enes",
        lastName: "Cerrahoğlu",
        description: "Bilgisayar Mühendisi",
        profilePhotoURL:
            "https://firebasestorage.googleapis.com/v0/b/taskmallow-app.appspot.com/o/team%2Fenes.jpg?alt=media&token=faac91a0-5467-4c4f-ab33-6f248ba88b75"),
    tasks: [],
    collaborators: [],
  ),
  ProjectModel(
    name: "Project 3",
    category: Categories.renewable_energy_sources,
    description:
        "TaskMallow, iş yönetimi ve inovasyonu bir araya getiren yenilikçi bir uygulamadır. Projelerinizi yönetmek, görevleri takip etmek, yaratıcı fikirler geliştirmek ve eşleşme özelliğiyle en uygun görevleri bulmak için tasarlanmıştır.",
    userWhoCreated: UserModel(
        email: "enescerrahoglu1@gmail.com",
        firstName: "Enes",
        lastName: "Cerrahoğlu",
        description: "Bilgisayar Mühendisi",
        profilePhotoURL:
            "https://firebasestorage.googleapis.com/v0/b/taskmallow-app.appspot.com/o/team%2Fenes.jpg?alt=media&token=faac91a0-5467-4c4f-ab33-6f248ba88b75"),
    tasks: [],
    collaborators: [],
  ),
];

List<UserModel> users = [
  UserModel(
      email: "enescerrahoglu1@gmail.com",
      firstName: "Enes",
      lastName: "Cerrahoğlu",
      description: "Bilgisayar Mühendisi",
      profilePhotoURL:
          "https://firebasestorage.googleapis.com/v0/b/taskmallow-app.appspot.com/o/team%2Fenes.jpg?alt=media&token=faac91a0-5467-4c4f-ab33-6f248ba88b75"),
  UserModel(
      email: "gul.aktopp@gmail.com",
      firstName: "Gülsüm",
      lastName: "Aktop",
      description: "Bilgisayar Mühendisi",
      profilePhotoURL:
          "https://firebasestorage.googleapis.com/v0/b/taskmallow-app.appspot.com/o/team%2Fg%C3%BCl.jpg?alt=media&token=4d5b013c-30c5-4ce4-a5c7-01a3c7b0ac38"),
  UserModel(
      email: "ozdamarsevval.01@gmail.com",
      firstName: "Şevval",
      lastName: "Özdamar",
      description: "Bilgisayar Mühendisi",
      profilePhotoURL:
          "https://firebasestorage.googleapis.com/v0/b/taskmallow-app.appspot.com/o/team%2F%C5%9Fevval.jpg?alt=media&token=bafb43ec-1dd3-4233-9619-9b1ed3e26189"),
  UserModel(
      email: "izzetjmy@gmail.com",
      firstName: "İzzet",
      lastName: "Jumaev",
      description: "Bilgisayar Mühendisi",
      profilePhotoURL:
          "https://firebasestorage.googleapis.com/v0/b/taskmallow-app.appspot.com/o/team%2Fizzet.jpg?alt=media&token=4e7aef85-9d1d-4cfd-9e2e-58388b6bbe4e"),
  UserModel(
      email: "msalihgirgin@gmail.com",
      firstName: "Muhammed Salih",
      lastName: "Girgin",
      description: "Bilgisayar Mühendisi",
      profilePhotoURL:
          "https://firebasestorage.googleapis.com/v0/b/taskmallow-app.appspot.com/o/team%2Fsalih.jpg?alt=media&token=7034fffb-51e0-4dac-9f00-498d9939be4a"),
];

List<TaskModel> tasks = [
  TaskModel(
    taskId: "T1",
    name: "LoginPage UI tasarımı kodlanacak.",
    description: "LoginPage UI tasarımı Figma'da yer alan tasarıma uygun şekilde kodlanacak.",
    situation: TaskSituation.to_do,
    collaboratorMail: "enescerrahoglu1@gmail.com",
  ),
  TaskModel(
    taskId: "T2",
    name: "RegisterPage UI tasarımı kodlanacak.",
    description: "RegisterPage UI tasarımı Figma'da yer alan tasarıma uygun şekilde kodlanacak.",
    situation: TaskSituation.to_do,
    collaboratorMail: "gul.aktopp@gmail.com",
  ),
  TaskModel(
    taskId: "T3",
    name: "HomePage UI tasarımı kodlanacak.",
    description: "HomePage UI tasarımı Figma'da yer alan tasarıma uygun şekilde kodlanacak.",
    situation: TaskSituation.done,
    collaboratorMail: "ozdamarsevval.01@gmail.com",
  ),
  TaskModel(
    taskId: "T4",
    name: "SettingsPage UI tasarımı kodlanacak.",
    description: "SettingsPage UI tasarımı Figma'da yer alan tasarıma uygun şekilde kodlanacak.",
    situation: TaskSituation.done,
    collaboratorMail: "enescerrahoglu1@gmail.com",
  ),
  TaskModel(
    taskId: "T5",
    name: "ProfilePage UI tasarımı kodlanacak.",
    description: "ProfilePage UI tasarımı Figma'da yer alan tasarıma uygun şekilde kodlanacak.",
    situation: TaskSituation.to_do,
    collaboratorMail: "msalihgirgin@gmail.com",
  ),
  TaskModel(
    taskId: "T6",
    name: "ProjectsPage UI tasarımı kodlanacak.",
    description: "ProjectsPage UI tasarımı Figma'da yer alan tasarıma uygun şekilde kodlanacak.",
    situation: TaskSituation.in_progress,
    collaboratorMail: "izzetjmy@gmail.com",
  ),
];

class UserModel {
  String email;
  String firstName;
  String lastName;
  String profilePhotoURL;
  String description;
  UserModel({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.profilePhotoURL,
    required this.description,
  });
}

class TaskModel {
  String taskId;
  String name;
  String description;
  TaskSituation situation;
  String collaboratorMail;

  TaskModel({
    required this.taskId,
    required this.name,
    required this.description,
    required this.situation,
    required this.collaboratorMail,
  });
}

class ProjectModel {
  String name;
  String description;
  Categories category;
  UserModel userWhoCreated;
  List<TaskModel> tasks;
  List<UserModel> collaborators;

  ProjectModel({
    required this.name,
    required this.description,
    required this.category,
    required this.userWhoCreated,
    required this.tasks,
    required this.collaborators,
  });
}

class InvitationModel {
  String id;
  ProjectModel projectModel;
  String to;

  InvitationModel({
    required this.id,
    required this.projectModel,
    required this.to,
  });
}
