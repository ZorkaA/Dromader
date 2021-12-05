

#On verifie et on largue
var dropTanks = func(){
        for(var i = 2 ;i < 5 ; i = i + 1 ){
           var select = getprop("sim/weight["~ i ~"]/selected");
           if(select == "droptank"){ load.dropLoad(i);}

        }
}



#La boite de dialogue
#var ext_loads_dlg = gui.Dialog.new("dialog","Aircraft/F-15-ACTIVE/Dialogs/external-loads.xml");

#Begining of the dropable function.
#It has to be simplified and generic made
#Need to know how to make a table
dropLoad = func (number) {
          var select = getprop("sim/weight["~ number ~"]/selected");
          if(select != "none"){
                if(select == "Droptank"){
                     tank_submodel(number,select);
                     setprop("consumables/fuel/tank["~ number ~"]/selected", 0);
                     settimer(func load.dropLoad_stop(number),2);
                     setprop("controls/armament/station["~ number ~"]/release", 1);
                     setprop("sim/weight["~ number ~"]/selected", "none");
                     setprop("sim/weight["~ number ~"]/weight-lb", 0);
                }else{
                     load.dropMissile(number);
                     settimer(func load.dropLoad_stop(number),0.5);
                }


           }

           
}


#Need to be changed
dropLoad_stop = func(n) {     
         setprop("controls/armament/station["~ n ~"]/release", 0);
}





dropMissile = func (number) { 

  var target  = hud.closest_target();
  if(target == nil){ return;}

  
        #print(typeMissile);


          var typeMissile = getprop("sim/weight["~ number ~"]/selected");
          missile.Loading_missile(typeMissile);
          Current_missile = missile.MISSILE.new(number);
          Current_missile.status = 0;
          Current_missile.search(target);             
          Current_missile.release();
          setprop("controls/armament/station["~ number ~"]/release", 1);
          setprop("sim/weight["~ number ~"]/selected", "none");
          setprop("sim/weight["~ number ~"]/weight-lb", 0);
     

}

#var tank_submodel = func (pylone, select){

        #Drop Tanks
        #if(pylone == 1 and select == "Droptank"){ setprop("controls/armament/station[1]/release-droptank", 1);}
        #if(pylone == 4 and select == "Droptank"){ setprop("controls/armament/station[5]/release-droptank", 1);}
        #if(pylone == 7 and select == "Droptank"){ setprop("controls/armament/station[9]/release-droptank", 1);}


#}




