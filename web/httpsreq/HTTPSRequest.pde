import java.net.MalformedURLException;
import java.net.URL;
import java.security.cert.Certificate;
import java.io.*;

import javax.net.ssl.HttpsURLConnection;
import javax.net.ssl.SSLPeerUnverifiedException;

void setup(){
  HttpsClient h = new HttpsClient();
  h.req("https://api.hypixel.net/player?key=200fb72d-2eaf-484c-99b1-6c3e21a8f2b2&name=lalaoopybee");
}

class HttpsClient{ 
  private void req(String https_url){
    URL url;
    try{
      url = new URL(https_url);
      HttpsURLConnection con = (HttpsURLConnection)url.openConnection();   
      print_content(con);     
    }    
    catch(MalformedURLException e){}
    catch(IOException e){}
  }
    
  private void print_content(HttpsURLConnection con){
    if(con!=null){     
      try {
        String out = "";
        BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));       
        String input;       
        while((input=br.readLine())!=null){
          out+=input;
        }
        br.close();
        println(out);
      } 
      catch (IOException e){}    
    }    
  }   
}
