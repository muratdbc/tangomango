

get '/users/new' do
  erb :signup
end

post '/users' do
  if User.exists?(:username => params[:username])
    @error = "That username is already registered"
    erb :signup
  elsif User.exists?(:email => params[:email])
    @error = "That email is already registered"
    erb :signup
  else
    user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
    if user.nil?
      @error = "Invalid credentials" #fallback unknown error message
    else
      session[:user_id] = user.id
      redirect '/'
    end
  end
end

post '/sessions' do
  user = User.find_by(:email => params[:email])
  if user.nil?
    #incorrect email
    erb :index
  elsif user.password == params[:password]
    session[:user_id] = user.id
    redirect '/'
  else
    #incorrect password
    erb :index
  end
end

get '/logout' do
  session[:user_id] = nil
  redirect '/'
end

