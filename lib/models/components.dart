class Components {
  List<String> _components;
  List<String> get components => _components;
  Components({
    List<String> comp,
  }) {
    if (comp == null)
      _components = <String>[];
    else
      _components = comp;
  }

  void add(String component) {
    _components.add(component);
  }

  @override
  String toString() {
    final query = [];
    if (_components.length > 0) {
      _components.forEach((component) => query.add('country:$component'));
    } else {}
    return query.join('|');
  }

  //does component has same entities regardless to order
  @override
  bool operator ==(Object other) {
    if (other is Components) if (this.components.length ==
        other.components.length) {
      for (int i = 0; i < this.components.length; i++) {
        if (!this.components.contains(other.components[i]))
          return false;
        else if (!other.components.contains(this.components[i])) return false;
      }
      return true;
    }
    return false;
  }

  @override
  int get hashCode => super.hashCode;
}
