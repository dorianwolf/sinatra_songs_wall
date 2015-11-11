# Homepage (Root path)

helpers do
  def current_user
    if session[:id] and user = User.find(session[:id])
      user
    else
      false
    end
  end
  def get_comments(id)
    output = []
    all_reviews = Review.all.order(updated_at: :desc)
    output = all_reviews.where song_id: id
  end
end

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

get '/songs/:id' do
    @error = 'You must be logged in to review'
    @song = Song.find params[:id]
    @comments = get_comments(params[:id])
    erb :'songs/show'
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
  poster = current_user
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

post '/songs/:id/review' do
  user = current_user
  song = Song.find(params[:id])
  @review = Review.new
  @review.user_id = user.id
  @review.song_id = song.id
  @review.content = params[:content]
  @review.save
  redirect '/songs'
end
