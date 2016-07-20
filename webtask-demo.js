var parallel    = require('async').parallel;
var MongoClient = require('mongodb').MongoClient;
var request = require('request');

function ApplicationUser(UUID, deviceType, systemVersion, deviceName, country, timeZone, applicationVersion, lastConnection) {
	this.UUID = UUID;
	this.deviceType = deviceType;
	this.systemVersion = systemVersion;
	this.deviceName = deviceName;
	this.country = country;
	this.timeZone = timeZone;
	this.applicationVersion = applicationVersion;
	this.lastConnection = lastConnection;
};
ApplicationUser.prototype.getContentForUpdating = function(){
	return { deviceType: this.deviceType,
			 systemVersion: this.systemVersion,
			 deviceName: this.deviceName,
			 country: this.country,
			 timeZone: this.timeZone,
			 version: this.applicationVersion,
			 lastConnection: this.lastConnection
			}
};

function saveApplicationUser(applicationUser, db, cb) {

	var id = {
		UUID: applicationUser.UUID
	};

	db.collection('application_user').updateOne(id, { $set: applicationUser.getContentForUpdating() }, { upsert: true }, function (err) {
		if(err) return cb(err);	

		cb(null);
	});	    
}

function saveUserLog(UUID, date, db, cb) {
	db.collection('logs').save({ UUID: UUID, date: date}, function (err) {
		if(err) return cb(err);	

		cb(null);
	});	  
}

module.exports = function(ctx, done) {
  	var applicationUser = new ApplicationUser(ctx.data.UUID, ctx.data.deviceType, ctx.data.systemVersion, ctx.data.deviceName, ctx.data.country, ctx.data.timeZone, ctx.data.version, ctx.data.lastConnection);
   	var asyncTasks = [];

    MongoClient.connect(ctx.data.MONGO_URL, function (err, db) {
    	if(err) return done(err);

		asyncTasks.push( function (cb) {
			saveApplicationUser(applicationUser, db, function (err) {
				if(err) return cb(err);
    			cb(null);
			});
		});
		asyncTasks.push( function (cb) {
			saveUserLog(ctx.data.UUID,ctx.data.date, db, function (err) {
				if(err) return cb(err);
    			cb(null);
			});
		});
		parallel(asyncTasks, function (err){
    		if(err) return done(err);
    		var urlForNotifying = 'https://webtask.it.auth0.com/api/run/wt-j_regnauld-gmail_com-0/webtask-call-slack?webtask_no_cache=1&UUID=' + applicationUser.UUID;
    		request.get(urlForNotifying).on('response', function(response) {
    			done(null, 'Success. ' + response.statusCode);
  			}).on('error', function(err) {
   				 done(err);
  			});
    	});
    });
}