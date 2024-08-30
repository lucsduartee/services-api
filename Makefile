api-startup:
	echo $(RAILS_MASTER_KEY) > ./config/master.key
	rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'