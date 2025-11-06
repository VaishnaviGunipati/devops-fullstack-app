# Stage 1: Build the React app
FROM node:18-alpine AS build
WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy rest of the app code and build it
COPY . .
RUN npm run build

# Stage 2: Serve with Nginx
FROM nginx:stable-alpine
WORKDIR /usr/share/nginx/html

# Copy the built React app from the previous stage
COPY --from=build /app/build .

# Expose port 80
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]


