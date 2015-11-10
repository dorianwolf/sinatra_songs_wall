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

get '/users/signup' do
  @users = User.all
  erb :'users/signup'
end

post '/songs' do
  @song = Song.new(
  author: params[:author],
  title: params[:title],
  url: params[:url],
  user_id: session[:id]
  )
  if @song.save
    redirect '/songs'
  else
    erb :'songs/new'
  end
end

post '/users' do
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
