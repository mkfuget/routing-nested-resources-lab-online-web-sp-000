class SongsController < ApplicationController
  def index
    puts params
    if params[:artist_id].blank?
      @songs = Song.all
    else
      @artist = Artist.find_by(id: params[:artist_id])
      if !@artist.blank?
        @songs = @artist.songs
      else
        flash[:alert] = "Artist not found."
        redirect_to artists_path
      end
    end
  end

  def show
    puts params
    flash[:alert] = "Song not found."

    if params[:artist_id].blank?
      @songs = Song.all
    else
      @artist = Artist.find_by(id: params[:artist_id])
      @song = Song.find_by(params[:id])
      if @song !=nil && @song.artist == @artist
        @songs = @artist.songs
      else
        flash[:alert] = "Song not found."
        redirect_to artist_songs_path(@artist)
      end
    end


  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(song_params)

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name)
  end
end
