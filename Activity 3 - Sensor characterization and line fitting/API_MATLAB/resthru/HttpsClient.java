/*
 * HTTP Methods called with Java class Http(s)URLConnection
 *
 * Eleri Cardozo, Jan 2014
 *
 */

package resthru;

import java.io.*;
import java.net.*;
import javax.net.ssl.*;

public class HttpsClient {

    int statusCode;
    String contentType;
    String cookie;
    String connection;
    String location;
    int contentLength;

    public HttpsClient() {
	acceptSSL();
	statusCode = 0;
	contentType = "";
	cookie = "";
        connection = "keep-alive";
	location = "";
	contentLength = 0;
    }

    // get code of last transaction
    public String getStatusCode() {
	return String.valueOf(statusCode);
    }

    // content type of the last transaction
    public String getContentType() {
	return contentType;
    }

    // cookie
    public void setCookie(String ck) {
	cookie = ck;
    }

    // location header of the last transaction
    public String getLocation() {
	return location;
    }

    // connection: keep-alive (default) or close
    public void setConnection(String conn) {
	connection = conn;
    }

    // content length of the last transaction
    public int getContentLength() {
	return contentLength;
    }

    // trust any certificate
    public void acceptSSL() {
	// Create a trust manager that does not validate certificate chains
	TrustManager[] trustAllCerts = new TrustManager[] {
	    new X509TrustManager() {
		public java.security.cert.X509Certificate[] 
		    getAcceptedIssuers() {
		    return null;
		}
	 
		public void checkClientTrusted(
			     java.security.cert.X509Certificate[] certs, 
			     String authType) {
		}
	 
		public void checkServerTrusted(
			     java.security.cert.X509Certificate[] certs, 
			     String authType) {
		}
	    }
        };
	 
	// Install the all-trusting trust manager
	try {
	    SSLContext sc = SSLContext.getInstance("SSL");
	    sc.init(null, trustAllCerts, new java.security.SecureRandom());
	    HttpsURLConnection.setDefaultSSLSocketFactory(sc.getSocketFactory());
	} catch (Exception e) {
      }    	
    }
	

    // perform an Http transaction
    public String sendRequest(String method,     // GET, POST, PUT, DELETE
			      String address,    // http://...
			      String ctype,      // application/json, ... 
			      String payload) {  // null for GET, DELETE

	try {
	    URL url = new URL(address);
	    HttpURLConnection request = null;
	    HostnameVerifier hv = new HostnameVerifier() {
	    	    public boolean verify(String urlHostName, 
					  SSLSession session) {
	    	        return true;
	    	    }
		};
	    HttpsURLConnection.setDefaultHostnameVerifier(hv);
	    HttpsURLConnection conn = 
			(HttpsURLConnection)url.openConnection();
	    request = conn;
	    request.setUseCaches(false);
	    request.setDoOutput(true);
	    request.setDoInput(true);
	    request.setFollowRedirects(true);
            request.setReadTimeout(5000);
	    request.setInstanceFollowRedirects(true);
	    request.setRequestProperty("Connection", connection);
	    if(ctype.length() > 0)
		request.setRequestProperty("Content-Type", ctype);
	    if(cookie.length() > 0) 
		request.setRequestProperty("Cookie", cookie + "=" + address);
	    request.setRequestMethod(method);
	    if(payload.length() > 0) {
		request.setRequestProperty("Content-Length", 
					   String.valueOf(payload.length()));
		OutputStreamWriter post = 
		    new OutputStreamWriter(request.getOutputStream());
		post.write(payload);
		post.flush();
	       	post.close();
	    }
	    statusCode = request.getResponseCode();
	    contentType = request.getContentType();
	    contentLength = request.getContentLength();  
	    location = request.getHeaderField("Location");
	    if(location == null) location = "";
	    if(statusCode >= 200 && statusCode <= 202 && 
	       contentLength != 0) {  // OK
		BufferedReader in = 
		    new BufferedReader(new InputStreamReader(
					   request.getInputStream()));
		String inputLine;
		String content = "";
		while ((inputLine = in.readLine()) != null) {
		    content += inputLine;
		}
		in.close();
		return content;
	    }
	    return "";  // error code or no content
	} catch (IOException e) {
	    System.out.println(e.getMessage());
	    statusCode = 500;  // assume internal server error
	    return "";
	}
    }
}

