class CommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		post= Post.find(params[:post_id])
		comment= post.comments.new(comments_parameters)
			
		if comment.save
			flash[:success] = "Comentario Creado"
		else
			@errors= comment.errors.full_messages
			flash[:danger] = @errors
		end
		redirect_to post		
	end


	def destroy
	end

	private

	def comments_parameters
		params.required(:comment).permit(:body).merge(user_id: current_user.id)
	end
end
