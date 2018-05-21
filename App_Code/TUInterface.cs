using System;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Configuration;
using System.Collections.Generic;

/// <summary>
/// Summary description for TUInterface
/// </summary>
public class TUInterface
{
	public TUInterface()
	{
		//
		// TODO: Add constructor logic here
		//
	}
    static string TU_IP = ConfigurationManager.AppSettings["TU_IP"];
    static string TU_Port = ConfigurationManager.AppSettings["TU_Port"];

    public static string StartClient(string tuRequest)
    {
        return "test";
        // Data buffer for incoming data.  
        byte[] bytes = new byte[1024];
        Log.Error("Start");

        // Connect to a remote device.  
        try
        { 
            IPAddress ipAddress = System.Net.IPAddress.Parse(TU_IP);
            int portNo = Convert.ToInt32(TU_Port); //test port no.
             
            IPEndPoint remoteEP = new IPEndPoint(ipAddress, portNo);

            // Create a TCP/IP  socket.  
            Socket sender = new Socket(ipAddress.AddressFamily,
                SocketType.Stream, ProtocolType.Tcp);

            // Connect the socket to the remote endpoint. Catch any errors.  
            try
            {
                sender.Connect(remoteEP);

                Console.WriteLine("Socket connected to {0}",
                    sender.RemoteEndPoint.ToString());
                 
                // Encode the data string into a byte array.  
                char controls = (char)19;
                // string tstuef
                // = "TUEF10BASE TUEF ENQUIRY RECORDSFF21520790TU2577185710000050000HKDEN03CC001YYYY  A000000000";
                // string tstuef2 = "NA03N010504LXXX0807LXX YXX0904JXXX1108021119611308A01858791402ID1503HKG";
                // string tstuef3 = "AD03A010145C/O WING ON MEDICINE LTD 35C G/F FOOK ON BLDG0232SHEK KIP MEI ST SHAM SHUI PO KLN";
                // string tstuef4 = "AS03A01010800000001ES02**";

                byte[] msg = Encoding.ASCII.GetBytes(string.Format("{0}{1}",
                    tuRequest, controls));

                // Send the data through the socket.  
                int bytesSent = sender.Send(msg);

                // Receive the response from the remote device.  
                //sender.ReceiveTimeout = 10000;
                int bytesRec = sender.Receive(bytes);
                Console.WriteLine("Echoed test = {0}",
                    Encoding.ASCII.GetString(bytes, 0, bytesRec));

                // Release the socket.  
                sender.Shutdown(SocketShutdown.Both);
                sender.Close();

                return Encoding.ASCII.GetString(bytes, 0, bytesRec);
            }
            catch (ArgumentNullException e)
            {
                //Console.WriteLine("ArgumentNullException : {0}", ane.ToString());
                Log.Error(e.Message);
                Log.Error(e.StackTrace);
            }
            catch (SocketException e)
            {
                //Console.WriteLine("SocketException : {0}", se.ToString());
                Log.Error(e.Message);
                Log.Error(e.StackTrace);
            }
            catch (Exception e)
            {
                //Console.WriteLine("Unexpected exception : {0}", e.ToString());
                Log.Error(e.Message);
                Log.Error(e.StackTrace);
            }


        }
        catch (Exception e)
        {
            //Console.WriteLine(e.ToString());
            Log.Error(e.Message);
            Log.Error(e.StackTrace);
        }

        return "";
    }
}