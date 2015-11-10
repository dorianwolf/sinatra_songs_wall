# Homepage (Root path)

get '/' do
  erb :index
end

get '/songs' do
  @songs = Song.all
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
  @user = User.new(
  name: params[:name],
  password: params[:password]
  )
  if @user.save
    session[:id] = @user.id
    redirect '/songs'
  else
    erb :'users/signup'
  end
end

post '/songs/:id' do
  song = Song.find(params[:id])
  song.upvotes += 1
  song.save
  redirect '/songs'
end
