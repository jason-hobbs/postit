class CommentsController < ApplicationController
  before_action :require_user

  def create
    @post = Post.find_by(slug: params[:post_id])
    @comment = @post.comments.build(params.require(:comment).permit(:body))
    @comment.user_id = current_user.id
    @comment.created_at = Time.now

    if @comment.save
      flash[:notice] = "Comment created"
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end

  def vote
    @comment = Comment.find(params[:id])
    @vote = Vote.create(voteable: @comment, creator: current_user, vote: params[:vote])
    respond_to do |format|
      format.html do
        if @vote.valid?
          flash[:notice] = "Vote was counted."
        else
          flash[:notice] = "Already voted on this comment."
        end
        redirect_to :back
      end
      format.js
    end
  end




end
