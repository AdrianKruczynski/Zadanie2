FROM node:alpine
# ustawienie zmiennej środowiskowej
ENV NODE_OPTIONS=--openssl-legacy-provider
# ustawienie katalogu roboczego 
WORKDIR '/app'
# kopiowanie pliku package.json do katalogu roboczego
COPY package.json .
#instalowanie zależności 
RUN npm install
# kopiowanie plików do katalogu roboczego
COPY . .
# budowanie aplikacji
RUN npm run build 



FROM nginx
# deklaracja wystawienia portu
EXPOSE 80
# kopiowanie zawatości katalogu "/app/build" z poprzedniego etapu budowania obrazu do "/usr/share/nginx/html"
COPY --from=0 /app/build /usr/share/nginx/html
