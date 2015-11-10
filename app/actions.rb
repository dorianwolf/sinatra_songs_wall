# Homepage (Root path)

get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all.order(upvotes: :desc)
  erb :'songs/index'
end

get '/songs/new' do
  @song = Song.new
  erb :'songs/new'
end

get '/users/login' do
  @user = User.new
  erb :'users/login'
end

get '/users/logout' do
  session.delete(:id)
  redirect '/'
end

get '/users/signup' do
  @user = User.new
  erb :'users/signup'
end

post '/songs' do
  user = User.find(session[:id])
  @song = Song.new(
  title: params[:title],
  url: params[:url],
  user_id: session[:id],
  username: user.name,
  upvotes: 0
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

post '/users/login' do
  user = User.find_by(name: params[:name])
  if user && user.password == params[:password]
    session[:id] = user.id
    redirect '/songs'
  else
    @error = 'Invalid username or password'
    erb :'users/login'
  end
end

post '/users/signup' do
  @user = User.new
  @user.name = params[:name]
  @user.password = params[:password]
  @user.save
  session[:id] = @user.id
  redirect '/songs'
end

post '/songs/:id' do
  song = Song.find(params[:id])
  poster = User.find(session[:id])
  not_upvoted = true
  song.user.each do |u|
    not_upvoted = false if u.name == poster.name
  end
  if not_upvoted
    song.user << poster
    song.upvotes += 1
    song.save
    redirect '/songs'
  else
    redirect '/songs'
  end
end
