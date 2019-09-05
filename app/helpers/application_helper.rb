module ApplicationHelper

    def readable_time(time)
        time.strftime("%d-%m-%Y, %I:%M %P")
    end

    def readable_fulltime(time)
        time.strftime("%e %b %Y %H:%M:%S%p")
    end

    def readable_hour(time)
        time.strftime("%I:%M %P")
    end

    def reserve_boolean(boolean)
        boolean ? 'Para Servir' : 'Para Llevar'
    end
    
    # Sube una imagen a s3 enviada desde un formulario
    # Parametros: Image: Archivo subido por el usuario, 
    #             Image_name, nombre del archivo, Image_type: Tipo de imagen(Png, jpeg, jpg)
    def uploadImageToS3(image, image_name, image_type) 
      require 'aws-sdk'

      my_bucket = 'isaprespdf-informacionisapres-repository'
      my_bucket_region = 'us-east-2'
      img_name_final =  (Time.now.to_i.to_s+image_name).gsub(/\s+/, "")  # Se agrega un timestamps al nombre para que siempre sea unico
      # Se configura el repositorio
      s3 = Aws::S3::Client.new(
        region: my_bucket_region,
        credentials: Aws::Credentials.new('AKIAI5RMYLNL4WTHDJXA', 'Z7ZUKi7Tc9cTPWesuj0zVIK0LIUGbUI+rWXGKeJW')
      )

      # Guarda la respuesta de la subida al servidor
      resp = s3.put_object({
        acl: "public-read",
        body: image, 
        bucket: my_bucket, 
        key: img_name_final, 
        content_type: image_type
      })

      # Logs
      puts 'Respuesta de subida a S3'
      puts resp
      puts "https://#{my_bucket}.s3.#{my_bucket_region}.amazonaws.com/#{img_name_final}"
      return "https://#{my_bucket}.s3.#{my_bucket_region}.amazonaws.com/#{img_name_final}"

    end
end
