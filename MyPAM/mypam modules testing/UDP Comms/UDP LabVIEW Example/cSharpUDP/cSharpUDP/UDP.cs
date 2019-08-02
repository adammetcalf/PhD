using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Net;
using System.Net.Sockets;
using System.IO;
using Newtonsoft.Json;

namespace cSharpUDP
{
    public partial class UDP : Form
    {
        UdpClient Client = new UdpClient(65530); //this PC's port number for receiving UDP data from myRIO
        string rxData = ""; //variable name for received data from myRIO

        public class deserialisedRX //class for JSON format message received from myRIO, uses Newtonsoft.json
        {
            public double Xpos { get; set; }
            public double Ypos { get; set; }
            public double Fx { get; set; }
            public double Fy { get; set; }
        }

        public UDP() //Builds and starts the windows form
        {
            InitializeComponent();

        }


        // this code runs when the form starts running.
        private void UDP_Load(object sender, EventArgs e)
        {

        }

        // this code runs when the close button is pressed.
        private void closeButton_Click(object sender, EventArgs e)
        {
            if (true)
                Application.Exit(); //closes the application
        }

        private void startButton_Click(object sender, EventArgs e) //start receiving
        {
            try //try to receive the UDP transfer
            {

                Client.BeginReceive(new AsyncCallback(recv), null); //Receive remote data
            }

            catch(Exception ex) //if error, run this code
            {
                receiveData.Text += ex.Message.ToString(); //print the message to the RX textbox

            }
        }

        void recv(IAsyncResult res) //Receive UDP transmission
        {
            IPEndPoint RemoteIP = new IPEndPoint(IPAddress.Any, 60000); //defining the remote Device and sending port (though it seems that any value for port will do)
            byte[] received = Client.EndReceive(res, ref RemoteIP); //get the data
            rxData = Encoding.UTF8.GetString(received); //transform the data

            //To avoid cross threading we use method invoker.
            this.Invoke(new MethodInvoker(delegate
            {

                //deserialise JSON according to the deserialisedRX class defined above. dsRx is the object.
                deserialisedRX dsRX = JsonConvert.DeserializeObject<deserialisedRX>(rxData);

                receiveData.Clear(); //clear the textbox to remove all old data
                receiveData.Text += rxData + "\n \n";
                receiveData.Text += "Xpos = " + dsRX.Xpos + "mm\n"; //print the Xpos data to the RX textbox
                receiveData.Text += "Ypos = " + dsRX.Ypos + "mm\n"; //print the Ypos data to the RX textbox
                receiveData.Text += "Fx = " + dsRX.Fx + "N\n"; //print the new Fx to the RX textbox
                receiveData.Text += "Fy = " + dsRX.Fy + "N\n"; //print the new Fy to the RX textbox
            }));

            Client.BeginReceive(new AsyncCallback(recv), null); //begin receiving the data

        }
                       
    }
}
