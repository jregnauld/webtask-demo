var parallel    = require('async').parallel;
var MongoClient = require('mongodb').MongoClient;
var request = require('request');


function getUserInformation(UUID, db, cb) {
	db.collection('application_user').findOne({ "UUID": UUID }, function (err, user) {
			if(err) return cb(err);
			cb(null, user);
	});
}
function getNumberOfUserSession(UUID, db, cb) {
	db.collection('logs').find({ "UUID": UUID }).count(function (err, numberSessions) {
		if(err) return cb(err);
		cb(null, numberSessions);
	});
}
function getNumberOfUser(db, cb) {
	db.collection('application_user').find().count(function (err, numberUsers) {
		if(err) return cb(err);
		cb(null, numberUsers);
	});
}
module.exports = function (ctx, done) {
	MongoClient.connect(ctx.data.MONGO_URL, function (err, db) {
    	if(err) return done(err);
    	 getUserInformation(ctx.data.UUID, db, function (err, user) {
			if(err) return done(err);
			getNumberOfUserSession(user.UUID, db, function (err, numberSessions) {
				if(err) return done(err);
				getNumberOfUser(db, function (err, numberUsers) {
					if(err) return done(err);
					var userDescription = user.deviceName + ' ( device: ' + user.deviceType 
										+ ', iOS version: ' + user.systemVersion 
										+ ' application version: ' + user.version
										+ ', from: ' + user.country + ', time zone: ' + user.timeZone
										+ ')';
				// can't edit field on Maker :(
					var data = {
						"value1" : numberUsers,
						 "value2" : numberSessions,
						 "value3" : userDescription
					};
					request({
						url: 'https://maker.ifttt.com/trigger/app_opened/with/key/c8xzymb254DVBC0-ASAtXd',
						method: 'GET',
						json: data,
					}, function (error, response, body) {
						if(err) return done(err);
						done(null, JSON.stringify(data));
					});	
				});

			});
		});
    });
}