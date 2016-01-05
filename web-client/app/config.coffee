module.exports =
	oauth:
		gitlab_uri: 'https://git.creatale.de/oauth/authorize'
		client_id: '87a306f55e6430ea140d12dae3003fd518cc17d4b3dc7c858044ddbb1a269806'
		redirect_uri: 'http://localhost:9000/oauth/callback&response_type=code'

	google:
		oauth:
			client_id: '781491695896-777rtk56inl62ca7onasnhsaal6aoipl.apps.googleusercontent.com'
			scopes: ['https://www.googleapis.com/auth/calendar.readonly']
