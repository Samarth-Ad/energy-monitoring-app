import 'package:electricity_app_home/pages/calculations.dart';
import 'package:flutter/material.dart';
import 'package:electricity_app_home/Theme/theme_provider.dart';
import 'package:electricity_app_home/Theme/theme.dart';
import 'package:provider/provider.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final double voltage=220.0;//dummy vallue in volts
  final double current=5.0;//dummy vakue in amperes
  double power=0.0;//power initially zero in watts
  double cost=0.0;//Estimmated cost
  bool isCalculated=false;

  //Cost Calculation
  final double costPerUnit=7.0;//cost per unit in rupees
  final int hoursPerDay = 24; // Assuming usage for 24 hours a day
  final int daysInMonth = 30; // Assuming a month has 30 days

  void calculate()
  {
    //calculate power and cost
    power=voltage*current;//power in watts
    double units=(power/1000)*hoursPerDay*daysInMonth;//converting watt into units
    cost=units*costPerUnit;//Calculate cost
    isCalculated=true;
    setState(() {
      
    });//ui updation

  }

  @override
  Widget build(BuildContext context) {
    if (!isCalculated) {
    calculate(); // Call calculate if not already calculated
  }
    return  Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Center(child: Text("Electricity Monitoring",
        style: TextStyle(fontSize: 24),)),
        actions: [
          IconButton(onPressed: (){
            Provider.of<ThemeProvider>(context,listen: false).toggleTheme();
          }, icon: Icon(Icons.dark_mode)),
          IconButton(onPressed: (){}, icon: Icon(Icons.account_circle,size: 34,))
          
        ],
      ),
      
      drawer: Drawer(
  backgroundColor: Theme.of(context).colorScheme.secondary,
  child: Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween, // Change to start
    children: [
      
      Padding(
        padding: const EdgeInsets.only(top: 16.0),
        child: ExpansionTile(
          initiallyExpanded: false,
          leading: Icon(Icons.settings, size: 36,),
          title: Text(
            "Settings",
            style: TextStyle(fontSize: 36, color: Theme.of(context).colorScheme.tertiary),
          ),
          children: [
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text(
                "Enable Notification",
                style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.tertiary),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "About Device",
                style: TextStyle(fontSize: 24, color: Theme.of(context).colorScheme.tertiary),
              ),
            ),
          ],
        ),
      ),
      Spacer(), // Add Spacer to push Logout to the bottom
      Padding(
        padding: const EdgeInsets.only(top:16.0),
        child: ListTile(
          leading: Icon(Icons.logout, size: 36,),
          title: Text(
            "Logout",
            style: TextStyle(fontSize: 36, color: Theme.of(context).colorScheme.tertiary),
          ),
        ),
      ),
    ],
  ),
),
        body: Column(
          children: [

            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Center(
                
                child: Text("Calculation of Your energy \n consumption and cost \n             estimation",
                style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,
                ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
          


            const SizedBox(height: 20,),
            //Display results
            if(isCalculated)...[
            
            Text("Voltage💡💡: $voltage V ", style: const TextStyle(fontSize: 24,)),
            const SizedBox(height: 20,),
            Text("Current⚡⚡: $current A ", style:const TextStyle(fontSize: 24,)),
            const SizedBox(height: 20,),
            Text("Power Consumption🔌🔌: $power W ", style:const TextStyle(fontSize: 24,)),
            const SizedBox(height: 20,),
            Text("Estimated Cost: ₹${cost.toStringAsFixed(2)}", style: const TextStyle(fontSize: 24,)),
            ]
          ],
      )
    );
    
  }
}