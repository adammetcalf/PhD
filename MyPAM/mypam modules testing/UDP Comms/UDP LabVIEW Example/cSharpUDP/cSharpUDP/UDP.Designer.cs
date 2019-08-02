namespace cSharpUDP
{
    partial class UDP
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.closeButton = new System.Windows.Forms.Button();
            this.startButton = new System.Windows.Forms.Button();
            this.sendData = new System.Windows.Forms.TextBox();
            this.sendLabel = new System.Windows.Forms.Label();
            this.receiveLabel = new System.Windows.Forms.Label();
            this.receiveData = new System.Windows.Forms.RichTextBox();
            this.SuspendLayout();
            // 
            // closeButton
            // 
            this.closeButton.Location = new System.Drawing.Point(301, 204);
            this.closeButton.Name = "closeButton";
            this.closeButton.Size = new System.Drawing.Size(200, 68);
            this.closeButton.TabIndex = 0;
            this.closeButton.Text = "Close";
            this.closeButton.UseVisualStyleBackColor = true;
            this.closeButton.Click += new System.EventHandler(this.closeButton_Click);
            // 
            // startButton
            // 
            this.startButton.Location = new System.Drawing.Point(49, 204);
            this.startButton.Name = "startButton";
            this.startButton.Size = new System.Drawing.Size(200, 68);
            this.startButton.TabIndex = 1;
            this.startButton.Text = "Start";
            this.startButton.UseVisualStyleBackColor = true;
            this.startButton.Click += new System.EventHandler(this.startButton_Click);
            // 
            // sendData
            // 
            this.sendData.Location = new System.Drawing.Point(49, 30);
            this.sendData.Name = "sendData";
            this.sendData.Size = new System.Drawing.Size(452, 20);
            this.sendData.TabIndex = 2;
            // 
            // sendLabel
            // 
            this.sendLabel.AutoSize = true;
            this.sendLabel.Location = new System.Drawing.Point(46, 14);
            this.sendLabel.Name = "sendLabel";
            this.sendLabel.Size = new System.Drawing.Size(55, 13);
            this.sendLabel.TabIndex = 4;
            this.sendLabel.Text = "Sent Data";
            // 
            // receiveLabel
            // 
            this.receiveLabel.AutoSize = true;
            this.receiveLabel.Location = new System.Drawing.Point(46, 68);
            this.receiveLabel.Name = "receiveLabel";
            this.receiveLabel.Size = new System.Drawing.Size(79, 13);
            this.receiveLabel.TabIndex = 5;
            this.receiveLabel.Text = "Received Data";
            // 
            // receiveData
            // 
            this.receiveData.Location = new System.Drawing.Point(49, 84);
            this.receiveData.Name = "receiveData";
            this.receiveData.Size = new System.Drawing.Size(452, 114);
            this.receiveData.TabIndex = 6;
            this.receiveData.Text = "";
            // 
            // UDP
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(557, 310);
            this.Controls.Add(this.receiveData);
            this.Controls.Add(this.receiveLabel);
            this.Controls.Add(this.sendLabel);
            this.Controls.Add(this.sendData);
            this.Controls.Add(this.startButton);
            this.Controls.Add(this.closeButton);
            this.Name = "UDP";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.UDP_Load);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button closeButton;
        private System.Windows.Forms.Button startButton;
        private System.Windows.Forms.TextBox sendData;
        private System.Windows.Forms.Label sendLabel;
        private System.Windows.Forms.Label receiveLabel;
        private System.Windows.Forms.RichTextBox receiveData;
    }
}

