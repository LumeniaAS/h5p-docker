FROM drupal:7
MAINTAINER Emil Grunt <emil.grunt@lumenia.no>

WORKDIR /var/www/html/sites/all/modules
RUN mkdir contrib
WORKDIR /var/www/html/sites/all/modules/contrib

# https://www.drupal.org/node/1898096/release
ENV H5P_VERSION 1.13
ENV H5P_MD5 ae4a653338040826e1f8a8ba357589f6

RUN curl -fSL "https://ftp.drupal.org/files/projects/h5p-7.x-${H5P_VERSION}.tar.gz" -o h5p.tar.gz \
    && echo "${H5P_MD5} *h5p.tar.gz" | md5sum -c - \
    && tar -xz -f h5p.tar.gz \
    && rm h5p.tar.gz \
    && chown -R www-data:www-data h5p
    # Insert missing db specification into install script.
    && sed -i '437i \'not null\' => TRUE,' h5p/h5p.install
    && sed -i '849i \'not null\' => TRUE,' h5p/h5p.install
