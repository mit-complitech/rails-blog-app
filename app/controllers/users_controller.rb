class UsersController < ApplicationController

	before_action :find_user, except: [:create, :index]

	def index
		render json: { users: User.all,  message: "All users"  }, status: :ok
	end

	def create
		user = User.new(user_params)
		if user.save
			render json: { user: user,  message: "User created successfully.."  }, status: :created
		else
			render json: { message: "Something went wrong..", errors: @user.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def update
		if @user.update(user_params)
			render json: { user: @user,  message: "User updated successfully.."  }, status: :ok
		else
			render json: { message: "Something went wrong..", errors: @user.errors.full_messages  }, status: :unprocessable_entity
		end
	end

	def show
		render json: { user: @user, message: "User fetched successfully" }, status: :ok
	end

	def destroy
		if @user.destroy
			render json: { user: @user,  message: "User deleted successfully.." }, status: :ok
		else
			render json: { message: "Something went wrong..",  errors: user.errors.full_messages  }, status: :unprocessable_entity
		end
	end

	private

	def user_params
		params.require(:data).permit(:name, :email, :phone)
	end

	def find_user
		user_id = params[:id]
		@user = User.find(user_id)
	rescue Exception => e
		render json: { error: "User not found" }, status: :unprocessable_entity
	end

end