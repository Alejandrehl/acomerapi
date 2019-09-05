Rails.application.config.to_prepare do
  if defined?(ActiveStorage::Service::S3Service)
    # Make ActiveStorage as public-read. @dinatih
    ActiveStorage::Service::S3Service.class_eval do
      def upload(key, io, checksum: nil)
        instrument :upload, key: key, checksum: checksum do
          begin
            object_for(key)
              .put(upload_options.merge(body: io, content_md5: checksum, acl: 'public-read'))
          rescue Aws::S3::Errors::BadDigest
            raise ActiveStorage::IntegrityError
          end
        end
      end

      def url(key, expires_in:, filename:, disposition:, content_type:)
        instrument :url, key: key do |payload|
          generated_url = object_for(key).public_url
          payload[:url] = generated_url
          generated_url
        end
      end
    end
  end
end