this.name = "eight extractor";
this.description = "enable dumping of system info for each galaxy, to JSON in the oolite log";
this.version = 1.0;
this.author = "Andrew Bramble - a.k.a submersible"
this.copyright = "Creative Commons Attribution-NonCommercial 3.0 Unported License."


"use strict";

this.seen =[];

this._dump_galaxy = function (galnum) {
	if ( this.seen[galnum] == 1 ) {
		return;
	}
	var gal = new Object();
	gal.galaxy = galnum;
	gal.systems = new Object();
	for (var i=0;i<256;i++) {
		var sys = System.infoForSystem(galnum,i);
		// eek!
		var copy  = JSON.parse( JSON.stringify( sys ) );
		copy.coordinates =[ sys.coordinates.x , sys.coordinates.y ];
		gal.systems[i] =  copy;
	}
	log(this,JSON.stringify( gal ) );
	this.seen[galnum]=1;
}

this._reset_galdrive = function() {
	if ( player.ship.equipmentStatus("EQ_GAL_DRIVE") == "EQUIPMENT_OK" ) {

	} else {
		player.ship.awardEquipment("EQ_GAL_DRIVE");
	}
};

this.shipWillExitWitchspace = function () {
	this._dump_galaxy(galaxyNumber);
	this._reset_galdrive();

}

this.shipWillLaunchFromStation = function() {
	this._dump_galaxy(galaxyNumber);
	this._reset_galdrive();
}
