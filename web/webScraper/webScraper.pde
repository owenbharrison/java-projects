import java.net.URLConnection;
import java.net.URL;
import java.io.InputStreamReader;
import java.nio.charset.Charset;
import java.net.MalformedURLException;

void setup(){
  String htmlCode = "";
  try{
    URLConnection connection;
    connection = new URL("https://www.google.com/search?tbm=isch&q=" + "cats").openConnection();
    connection.setRequestProperty("User-Agent", "Mozilla/5.0 (Windows NT 6.1; WOW64) AppleWebKit/537.11 (KHTML, like Gecko) Chrome/23.0.1271.95 Safari/537.11");
    connection.connect();

    BufferedReader r  = new BufferedReader(new InputStreamReader(connection.getInputStream(), Charset.forName("UTF-8")));

    StringBuilder sb = new StringBuilder();
    String line;
    while ((line = r.readLine()) != null) {
      sb.append(line);
    }
    htmlCode = sb.toString();
    println("done");
  }
  catch(Exception e){e.printStackTrace();}
  
  new HTMLViewer().start(htmlCode);
}

void draw(){}
