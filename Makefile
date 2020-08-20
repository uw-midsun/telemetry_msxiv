# Allow linting on specific filepaths if needed
FILEPATH := 

.PHONY: lint
lint:
	@echo "Linting using flake8"
	@flake8 $(FILEPATH)

.PHONY: format
format: 
	@echo "Formatting all files using autopep8"
	@autopep8 --in-place --recursive .

.PHONY: test
test:
	@echo "Running pytest on all files"
	@pytest