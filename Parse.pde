class Parser{
   String xName;
   String yName;
   String[] names;
   float[] values;
   
   void parse(String file) {
    String[] lines = loadStrings(file);
    String[] headers = split(lines[0], ",");
    xName = headers[0];
    yName = headers[1];
    
    names = new String[lines.length - 1];
    values = new float[lines.length - 1];
    
    for(int i = 1; i < lines.length; i++){
      String[] data = split(lines[i], ",");
      names[i - 1] = data[0];
      values[i - 1] = int(data[1]);
    }
    changeValue();
   }
   
   void changeValue() {
     float total = 0;
     for(int i = 0; i < values.length; i++) {
       total += values[i];
     }
     for(int i = 0; i < values.length; i++) {
       values[i] = values[i]/total * 360;
     }
   }
}