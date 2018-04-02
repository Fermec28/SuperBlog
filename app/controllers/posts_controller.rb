class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	def index
		@posts= Post.all
	end

	def show
		@post= Post.find(params[:id])
	end

	def new
		@post= Post.new()

	end

	def create
		post =Post.new(post_parameters)		
		if post.save
			flash[:success] = "Post Creado"
			redirect_to post
		else
			@errors= post.errors.full_messages
			flash.now[:danger] = @errors
			@post= Post.new
			render :new
		end
	end

	def update
		post=Post.find(params[:id])
		if (post.user_id == current_user.id)
			if post.update(post_parameters)
				flash[:success] = "Post Actualizado"
				redirect_to post
			else
				@errors= post.errors.full_messages
				flash[:danger] = @errors
				redirect_to edit_post_path(post)
			end
		else
			flash.now[:danger]= "Usted no puede actualizar este post, permisos insuficientes"
			redirect_to root_path
		end		
	end	

	def edit
		@post= Post.find(params[:id])
	end

	def destroy
		post=Post.find(params[:id])
		if (post.user_id == current_user.id)
			post.destroy
			flash[:info] = "Post Eliminado"
		else
			flash.now[:danger]= "Usted no puede actualizar este post, permisos insuficientes"			
		end
		redirect_to root_path
	end

	private

	def post_parameters
		params.require(:post).permit(:body, :title).merge(user_id: current_user.id)
	end


end
