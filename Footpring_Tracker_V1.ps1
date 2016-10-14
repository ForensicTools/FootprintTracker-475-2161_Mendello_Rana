
#Program Requirements & Dependencies
# ShowUI Must be downloaded and installed
# SHowUI is used in the HELP Page
# ShowUI can be downloaded at: http://showui.codeplex.com/
# Example of how SHOWUI can be used: http://www.drdobbs.com/windows/building-gui-applications-in-powershell/240049898


# Create the form
# We must load two .NET classes:
#	System.Drawing
#	System.Windows.Forms

	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
	[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") 

#Modules to import
#ShowUI is used in HelpPage
	import-Module ShowUI

	
	
	function HelpPage
		{
			Show-UI {
			   StackPanel -Margin 10 -Children {
				  TextBlock "Footprint Tracker Help Page" -FontSize 42 -FontWeight Bold -Foreground "#00ff0c" 
				  TextBlock -FontSize 24 -Inlines {
					 Bold "Question "
					 "Do you want to leave us feedback? "
					 Hyperlink "Click for Developer Page" -NavigateUri https://github.com/ForensicTools/FootprintTracker-475-2161_Mendello_Rana `
											 -On_RequestNavigate { [Diagnostics.Process]::Start( $this.NavigateUri.ToString() ) }
				  }
TextBlock -FontSize 16 -Inlines {
Span -FontSize 24 -FontWeight Bold -Inlines "Project Purpose:"
"
The purpose of this program is simple, to provide the typical user 
a free and simple solution to finding out what their windows based 
computer knows about them. This will be a free tool geared for the 
average joe computer user, moms and dads etc."}
			}
			}
		}	



		
	function WindowsForm
		{
			# Now we can instantiate a new instance of the .NET Framework class System.Window.Forms.Form
			#	This will present the blank form (window) that we can add controls to
				$objForm = New-Object System.Windows.Forms.Form 


			#Now that we have an instance of the Form class we can then assign values to three properties of this class:
			#	Text - Disregard the name, this is actually the window title.
			#	Size - This is the size of the form, in pixels. In our case, we're creating a form that's 500 pixels wide by 300 pixels tall.
			#	StartingPosition - This is option; if this property is left out, Windows will pick a location to use when displaying this form. 
			#					   By setting the StartingPosition to CenterScreen our form will automatically be displayed in the middle of the screen each time it loads.
				$objForm.Text = "Footprint Tracker"
				$objForm.Size = New-Object System.Drawing.Size(500,300) 
				$objForm.StartPosition = "CenterScreen"


			# Here we are configuring our form to perform two things:
			#	1) Use the ENTER key instead of OK button.
			#	2) Use the ESC key instead of the Cancel button.
			<#
			In order to do this we first set the KeyPreview 
			property to true ($True); that tells the form to 
			intercept specific keystrokes rather than allow those 
			keystrokes to be used by the controls on the form. 
			What keystrokes do we want to capture? You got it: the ENTER 
			key and the ESC (Escape) key. Notice the syntax for capturing a 
			keystroke
			#>

				$objForm.KeyPreview = $True
				$objForm.Add_KeyDown({if ($_.KeyCode -eq "Enter") 
					{$x=$objTextBox.Text;$objForm.Close()}})
				$objForm.Add_KeyDown({if ($_.KeyCode -eq "Escape") 
					{$objForm.Close()}})
		
		
			Buttons
			MainMenuLabels
			MenuInput
			
		
		}
		


	function Buttons
	{
		$SubmitButton = New-Object System.Windows.Forms.Button
		$SubmitButton.Location = New-Object System.Drawing.Size(200,200)
		$SubmitButton.Size = New-Object System.Drawing.Size(75,23)
		$SubmitButton.Text = "Submit"
		$SubmitButton.Add_Click({$x=$objTextBox.Text;$objForm.Close()})
		$objForm.Controls.Add($SubmitButton)

		$ExitButton = New-Object System.Windows.Forms.Button
		$ExitButton.Location = New-Object System.Drawing.Size(275,200)
		$ExitButton.Size = New-Object System.Drawing.Size(75,23)
		$ExitButton.Text = "Exit"
		$ExitButton.Add_Click({$objForm.Close()})
		$objForm.Controls.Add($ExitButton)

		$AboutButton = New-Object System.Windows.Forms.Button
		$AboutButton.Location = New-Object System.Drawing.Size(400,5)
		$AboutButton.Size = New-Object System.Drawing.Size(75,23)
		$AboutButton.Text = "Help"
		$AboutButton.Add_Click({HelpPage})
		$objForm.Controls.Add($AboutButton)
	}


	function MainMenuLabels
	{
		$objLabel = New-Object System.Windows.Forms.Label
		$objLabel.Location = New-Object System.Drawing.Size(10,20) 
		$objLabel.Size = New-Object System.Drawing.Size(280,20) 
		$objLabel.Text = "Please Enter Operation Number"
		$objForm.Controls.Add($objLabel) 

		$objLabel = New-Object System.Windows.Forms.Label
		$objLabel.Location = New-Object System.Drawing.Size(40,50) 
		$objLabel.Size = New-Object System.Drawing.Size(280,20) 
		$objLabel.Text = "1) Recover Deleted Files"
		$objForm.Controls.Add($objLabel) 

		$objLabel = New-Object System.Windows.Forms.Label
		$objLabel.Location = New-Object System.Drawing.Size(40,70) 
		$objLabel.Size = New-Object System.Drawing.Size(280,20) 
		$objLabel.Text = "2) Parse Internet Browser History"
		$objForm.Controls.Add($objLabel) 
		 
		$objLabel = New-Object System.Windows.Forms.Label
		$objLabel.Location = New-Object System.Drawing.Size(40,90) 
		$objLabel.Size = New-Object System.Drawing.Size(280,20) 
		$objLabel.Text = "3) Exact Data Matching (EDM) Search"
		$objForm.Controls.Add($objLabel) 

		$objLabel = New-Object System.Windows.Forms.Label
		$objLabel.Location = New-Object System.Drawing.Size(40,110) 
		$objLabel.Size = New-Object System.Drawing.Size(280,20) 
		$objLabel.Text = "4) Analyze Documents"
		$objForm.Controls.Add($objLabel) 

		$objLabel = New-Object System.Windows.Forms.Label
		$objLabel.Location = New-Object System.Drawing.Size(40,130) 
		$objLabel.Size = New-Object System.Drawing.Size(280,20) 
		$objLabel.Text = "5) Regular Expression Search"
		$objForm.Controls.Add($objLabel) 
	}

	function MenuInput
	{
		$objTextBox = New-Object System.Windows.Forms.TextBox 
		$objTextBox.Location = New-Object System.Drawing.Size(140,175) 
		$objTextBox.Size = New-Object System.Drawing.Size(260,20) 
		$objForm.Controls.Add($objTextBox) 

		$objForm.Topmost = $True
		$objForm.Add_Shown({$objForm.Activate()})
		[void] $objForm.ShowDialog()
	}	

	
WindowsForm

# Source: https://technet.microsoft.com/en-us/library/ff730941.aspx
