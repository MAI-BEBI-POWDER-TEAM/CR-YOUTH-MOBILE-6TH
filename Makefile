# Makefile for deploying the Flutter web projects to GitHub

BASE_HREF = /CR-YOUTH-MOBILE-6TH/
# Replace this with your GitHub username
GITHUB_USER = andresaftari
GITHUB_REPO = https://github.com/MAI-BEBI-POWDER-TEAM/CR-YOUTH-MOBILE-6TH
BUILD_VERSION := $(shell grep 'version:' pubspec.yaml | awk '{print $$2}')

# Deploy the Flutter web project to GitHub
deploy:
ifndef OUTPUT
	$(error OUTPUT is not set. Usage: make deploy OUTPUT=<output_repo_name>)
endif

	@echo "Clean existing repository"
	flutter clean

	@echo "Getting packages..."
	flutter pub get

	@echo "Generating the web folder..."
	flutter create . --platform web

	@echo "Building for web..."
	flutter build web --base-href $(BASE_HREF) --release

	@echo "Deploying to git repository"
	cd build/web && \
	git init && \
	git add . && \
	git commit -m "Deploy Version $(BUILD_VERSION)" && \
	git branch -M main && \
	git remote add origin $(GITHUB_REPO) && \
	git push -u -f origin main

	@echo "✅ Finished deploy: $(GITHUB_REPO)"
	@echo "🚀 Flutter web URL:  https://mai-bebi-powder-team.github.io/CR-YOUTH-MOBILE-6TH/"

.PHONY: deploy