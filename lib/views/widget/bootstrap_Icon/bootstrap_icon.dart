import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/gym_home/gym_home_screen.dart';
import 'package:vlr/views/screens/dashboard/home_screen/All_home/room_home/room_home_screen.dart';

IconData getBootstrapIcon(String? iconName) {
  switch (iconName) {
    case 'bi-heart-pulse':
      return BootstrapIcons.heart_pulse;

    case 'bi-house-door':
      return BootstrapIcons.house_door;

    case 'bi-door-open':
      return BootstrapIcons.door_open;

    case 'bi-wifi':
      return BootstrapIcons.wifi;

    case 'bi-book':
      return BootstrapIcons.book;

    case 'bi-mortarboard':
      return BootstrapIcons.mortarboard;

    case 'bi-trophy':
      return BootstrapIcons.trophy;

    case 'bi-laptop':
      return BootstrapIcons.laptop;

    default:
      return BootstrapIcons.grid;
  }
}

Widget getNavigation(String? iconName) {
  switch (iconName) {
    case 'bi-heart-pulse':
      return GymHomeScreen();

    case 'bi-house-door':
      return GymHomeScreen();

    case 'bi-door-open':
      return RoomHomeScreen();

    case 'bi-wifi':
      return RoomHomeScreen();

    case 'bi-book':
      return RoomHomeScreen();

    case 'bi-mortarboard':
      return RoomHomeScreen();

    case 'bi-trophy':
      return RoomHomeScreen();

    case 'bi-laptop':
      return RoomHomeScreen();

    default:
      return RoomHomeScreen();
  }
}
