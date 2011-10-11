module FlickrFeed
  FlickRaw.api_key="8a82b5a4074ce3cea539edf10405aa0a"
  FlickRaw.shared_secret="11e0c00eb37d684b"
    
  def flickr_photo_in_set_url(owner, photo, set)
     "http://www.flickr.com/photos/#{owner}/#{photo}/in/set-#{set}/"
  end
  
  def photos_in_set(photoset_id, count=nil)
    begin
      params = {:photoset_id => photoset_id, :extras => ['title']}
      params[:per_page] = count if count
      photoset = flickr.photosets.getPhotos(params)
      photoset.photo.map do |p|
        { :id => p.id, :url => FlickRaw.url(p), :caption => p.title, :set_url => flickr_photo_in_set_url(photoset.owner, p.id, photoset_id) } 
      end
    rescue Exception => ex
      if production?
        raise ex
      else
        []
      end
    end
  end
  
  def people_photos
    photos_in_set(72157627741365001)
  end
  
  def project_photos(project, count=1)
    photoset_id = project['photoset_id']
    return [] unless photoset_id
    photos_in_set(photoset_id, count)
  end
  
end