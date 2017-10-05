class DataPoint {
  String name;
  float value;
  
  DataPoint(String name, float value) {
    this.name = name;
    this.value = value;
  }
}

class DataTable {
  String xName, yName;
  ArrayList<DataPoint> points;
  
  DataTable(String file) { 
    String[] lines = loadStrings(file);
    String[] headers = split(lines[0], ",");
    
    this.xName = headers[0];
    this.yName = headers[1];
    this.points = new ArrayList<DataPoint>();

    for (int i = 1; i < lines.length; i++) {
      String[] data = split(lines[i], ",");
      points.add(new DataPoint(data[0], int(data[1])));
    }
  }
}