# Stage 1: Build the React application
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /cao_jiale_final_site

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application
RUN npm run build

# Run linting and tests
RUN npm run lint
RUN npm run prettier:check
RUN npm test

# Serve the built application with a static server
FROM node:18-alpine

RUN npm install -g serve

WORKDIR /cao_jiale_final_site

COPY --from=build /cao_jiale_final_site/dist ./dist

EXPOSE 5575

# Serve the application at port 5575
CMD ["serve", "-s", "dist", "-l", "5575"]
