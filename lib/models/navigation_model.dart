import 'package:flutter/material.dart';

class NavigationModel {
  String title;
  IconData icon;
  int page;

  NavigationModel({this.title, this.icon, this.page});
}

List<NavigationModel> navigationItens = [
  NavigationModel(title: "Dashboard", icon: Icons.insert_chart, page: 0),
  NavigationModel(title: "Adicionar", icon: Icons.add_box, page: 1),
  NavigationModel(title: "Arquivos", icon: Icons.archive, page: 2),
  NavigationModel(title: "Comunidade", icon: Icons.people, page: 3),
  NavigationModel(title: "Compartilhar", icon: Icons.share, page: 4),
  NavigationModel(title: "Configurações", icon: Icons.settings, page: 5),
  NavigationModel(title: "Sair", icon: Icons.exit_to_app, page: 6),
];