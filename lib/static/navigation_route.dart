enum NavigationRoute {
  mainRoute('/'),
  detailRoute('/detail'),
  aboutRoute('/about');

  const NavigationRoute(this.name);
  final String name;
}
