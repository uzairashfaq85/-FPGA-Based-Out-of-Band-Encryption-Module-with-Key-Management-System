// Project: FPGA-Based Out-of-Band Encryption Module with Key Management System
// Module:  Windows host UART client (WinForms)
// Created: November 2025

using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.IO.Ports;

namespace WindowsFormsApplication1
{
    public partial class Form1 : Form
    {
        private string selectedKeyPath = "";
        private string selectedPlainPath = "";
        private string selectedCipherPath = "";

        private StringBuilder lineBuffer = new StringBuilder();
        public Form1()
        {
            InitializeComponent();
            getAvailablePorts();
            textBox1.Enabled = false;
            
            // Subscribe to DataReceived event
            serialPort1.DataReceived += new SerialDataReceivedEventHandler(DataReceivedHandler);
        }

        private void Form1_Load(object sender, EventArgs e)
        {

        }
        
        void getAvailablePorts()
        {
            string[] ports = SerialPort.GetPortNames();
            comboBox1.Items.Clear();
            comboBox1.Items.AddRange(ports);
            if (ports.Length > 0)
                comboBox1.SelectedIndex = 0;
        }

        protected override void OnFormClosing(FormClosingEventArgs e)
        {
            if (serialPort1 != null)
            {
                serialPort1.DataReceived -= DataReceivedHandler;
                if (serialPort1.IsOpen)
                {
                    serialPort1.Close();
                }
            }

            base.OnFormClosing(e);
        }

        private static string NormalizeHexPayload(string text)
        {
            if (string.IsNullOrWhiteSpace(text))
            {
                return string.Empty;
            }

            StringBuilder sb = new StringBuilder(text.Length);
            foreach (char c in text)
            {
                if ((c >= '0' && c <= '9') ||
                    (c >= 'a' && c <= 'f') ||
                    (c >= 'A' && c <= 'F'))
                {
                    sb.Append(char.ToUpperInvariant(c));
                }
            }

            return sb.ToString();
        }

        private string LoadHexPayload(string filePath, int expectedHexChars, string payloadName)
        {
            if (string.IsNullOrEmpty(filePath) || !System.IO.File.Exists(filePath))
            {
                MessageBox.Show("Please select a valid " + payloadName + " file first.", "No File Selected",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return null;
            }

            string fileContent = System.IO.File.ReadAllText(filePath);
            string payload = NormalizeHexPayload(fileContent);

            if (payload.Length == 0)
            {
                MessageBox.Show("Selected " + payloadName + " file does not contain hex data.", "Invalid File",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return null;
            }

            if (payload.Length != expectedHexChars)
            {
                MessageBox.Show(payloadName + " must be exactly " + expectedHexChars + " hex characters.", "Invalid Length",
                    MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return null;
            }

            return payload;
        }

        private void SendHexPayload(string payload)
        {
            serialPort1.Write(payload);
            serialPort1.Write("\n");
        }

        private void button3_Click(object sender, EventArgs e)
        {
            textBox2.Text = "";
            try
            {
                if (comboBox1.Text == "" || comboBox2.Text == "")
                {
                    textBox2.Text = "Please Select Port Settings";
                }
                else
                {
                    serialPort1.PortName = comboBox1.Text;
                    serialPort1.BaudRate = Convert.ToInt32(comboBox2.Text);
                    serialPort1.Open();
                    progressBar1.Value = 100;
                    button1.Enabled = true;
                    button3.Enabled = false;
                    button4.Enabled = true;
                    textBox1.Enabled = true;
                }
            }
            catch (UnauthorizedAccessException)
            {
                textBox2.Text = "Unauthorized Access";
            }
        }

        private void button4_Click(object sender, EventArgs e)
        {
            serialPort1.Close();
            progressBar1.Value = 0;
            button1.Enabled = false;
            button3.Enabled = true;
            button4.Enabled = false;
            textBox1.Enabled = false;
        }

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                if (!serialPort1.IsOpen)
                {
                    MessageBox.Show("Please open the serial port first.", "Port Not Open",
                        MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                string payload = LoadHexPayload(selectedKeyPath, 64, "Key");
                if (payload == null) return;

                SendHexPayload(payload);

                textBox6.AppendText(
                    "Key sent (" + payload.Length + " hex characters)\r\n");

                MessageBox.Show("Key sent successfully!", "Success",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error sending key: " + ex.Message, "Send Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }

        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button5_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Title = "Select File to Send";
            openFileDialog.Filter = "All Files (*.*)|*.*";
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                selectedPlainPath = openFileDialog.FileName;
                //textBox3.Text = selectedPlainPath;
                textBox3.Clear();
                textBox3.AppendText(System.IO.Path.GetFileName(selectedPlainPath) + "\r\n");
            }
        }

        private void button6_Click(object sender, EventArgs e)
        {
            try
            {
                // Check if a file is selected
                if (string.IsNullOrEmpty(selectedPlainPath) || !System.IO.File.Exists(selectedPlainPath))
                {
                    MessageBox.Show("Please select a valid file first using the Browse button.",
                                  "No File Selected",
                                  MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                // Read the file content
                string fileContent = System.IO.File.ReadAllText(selectedPlainPath);

                // Display in your textbox (replace existing content)
                textBox1.Text = "=== FILE CONTENT ===\r\n";
                textBox1.AppendText(fileContent);
                textBox1.AppendText("\r\n=== END OF FILE ===");

                // Optional: Show success message
                MessageBox.Show("File content loaded successfully!", "Success",
                              MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error reading file: " + ex.Message, "File Read Error",
                              MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void textBox3_TextChanged(object sender, EventArgs e)
        {
            
        }

        private void textBox4_TextChanged(object sender, EventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void textBox2_TextChanged(object sender, EventArgs e)
        {

        }
        
        // DataReceived event handler for automatic data display
        private void DataReceivedHandler(object sender, SerialDataReceivedEventArgs e)
        {
            try
            {
                SerialPort sp = (SerialPort)sender;

                int n = sp.BytesToRead;
                if (n <= 0) return;

                byte[] buf = new byte[n];
                sp.Read(buf, 0, n);

                string text = Encoding.ASCII.GetString(buf);

                // optional: live stream to textBox2 as well
                this.BeginInvoke(new Action(() =>
                {
                    lineBuffer.Append(text);

                    string content = lineBuffer.ToString();
                    int newlineIndex;

                    while ((newlineIndex = content.IndexOf('\n')) >= 0)
                    {
                        // Extract one full line
                        string line = content.Substring(0, newlineIndex).TrimEnd('\r');

                        // Print exactly one line
                        textBox2.AppendText(line + Environment.NewLine);

                        // Remove printed line from buffer
                        content = content.Substring(newlineIndex + 1);
                    }

                    // Keep remaining partial data
                    lineBuffer.Clear();
                    lineBuffer.Append(content);

                    textBox2.SelectionStart = textBox2.Text.Length;
                    textBox2.ScrollToCaret();
                }));

            }
            catch (Exception ex)
            {
                this.BeginInvoke(new Action(() =>
                {
                    textBox2.AppendText("RX error: " + ex.Message + Environment.NewLine);
                }));
            }
        }


        // Optional: Add a Clear button for textBox2
        private void button7_Click(object sender, EventArgs e)
        {
            textBox2.Clear();
        }

        private void button7_Click_1(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Title = "Select File to Send";
            openFileDialog.Filter = "All Files (*.*)|*.*";
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                selectedKeyPath = openFileDialog.FileName;
                //textBox5.Text = selectedKeyPath;
                textBox5.Clear();
                textBox5.AppendText(System.IO.Path.GetFileName(selectedKeyPath) + "\r\n");
            }


        }


        private void textBox5_TextChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            try
            {
                if (!serialPort1.IsOpen)
                {
                    MessageBox.Show("Please open the serial port first.", "Port Not Open",
                        MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                string payload = LoadHexPayload(selectedPlainPath, 32, "Plaintext");
                if (payload == null) return;

                SendHexPayload(payload);

                textBox4.AppendText(
                    "Plaintext sent (" + payload.Length + " hex characters)\r\n");

                MessageBox.Show("Plaintext sent successfully!", "Success",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error sending plaintext: " + ex.Message, "Send Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void button8_Click(object sender, EventArgs e)
        {
            try
            {
                if (!serialPort1.IsOpen)
                {
                    MessageBox.Show("Please open the serial port first.", "Port Not Open",
                        MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                string payload = LoadHexPayload(selectedCipherPath, 32, "Ciphertext");
                if (payload == null) return;

                SendHexPayload(payload);

                textBox8.AppendText(
                    "Ciphertext sent (" + payload.Length + " hex characters)\r\n");

                MessageBox.Show("Ciphertext sent successfully!", "Success",
                    MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error sending ciphertext: " + ex.Message, "Send Error",
                    MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void label4_Click(object sender, EventArgs e)
        {

        }

        private void textBox6_TextChanged(object sender, EventArgs e)
        {

        }

        private void button9_Click(object sender, EventArgs e)
        {
            OpenFileDialog openFileDialog = new OpenFileDialog();
            openFileDialog.Title = "Select File to Send";
            openFileDialog.Filter = "All Files (*.*)|*.*";
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                selectedCipherPath = openFileDialog.FileName;
                //textBox3.Text = selectedPlainPath;
                textBox7.Clear();
                textBox7.AppendText(System.IO.Path.GetFileName(selectedCipherPath) + "\r\n");
            }
        }

        private void button10_Click(object sender, EventArgs e)
        {
            try
            {
                // Check if a file is selected
                if (string.IsNullOrEmpty(selectedCipherPath) || !System.IO.File.Exists(selectedCipherPath))
                {
                    MessageBox.Show("Please select a valid file first using the Browse button.",
                                  "No File Selected",
                                  MessageBoxButtons.OK, MessageBoxIcon.Warning);
                    return;
                }

                // Read the file content
                string fileContent = System.IO.File.ReadAllText(selectedCipherPath);

                // Display in your textbox (replace existing content)
                textBox1.Text = "=== FILE CONTENT ===\r\n";
                textBox1.AppendText(fileContent);
                textBox1.AppendText("\r\n=== END OF FILE ===");

                // Optional: Show success message
                MessageBox.Show("File content loaded successfully!", "Success",
                              MessageBoxButtons.OK, MessageBoxIcon.Information);
            }
            catch (Exception ex)
            {
                MessageBox.Show("Error reading file: " + ex.Message, "File Read Error",
                              MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void textBox7_TextChanged(object sender, EventArgs e)
        {

        }

        private void textBox8_TextChanged(object sender, EventArgs e)
        {

        }
    }
}