.PHONY: test test-results 

mkfile_path:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))

TESTS=$(mkfile_path)
TESTS_RES=$(TESTS)/exp-res
TESTS_SRC=$(TESTS)/source
TESTS_OUT=out
TEXMF_TESTED=$(mkfile_path)/../texmf
TEXMF_STAMP=out/texmf.stamp

#
# Test working copy version
#
test:
ifdef TEST
	./run.sh -v -t $(TEST) $(TEXMF_TESTED) $(TESTS) $(TESTS_OUT)
else
	./run.sh -v $(TEXMF_TESTED) $(TESTS) $(TESTS_OUT)
endif

#
# Recreate tests expected results with current working copy
#
test_files:=$(addprefix $(TESTS_OUT)/,$(notdir \
	$(patsubst %.tex,%.pdf,$(wildcard $(TESTS_SRC)/t*.tex))))

test-results: $(test_files)
	# TODO this recipe should be called regardless prerequsities success
	rm $(TEXMF_STAMP)


$(TEXMF_STAMP):
	touch $@

# PNG files are created as side-effect of this rule
$(TESTS_OUT)/%.pdf: $(TESTS_SRC)/%.tex $(TEXMF_STAMP)
	@rm -f $(TESTS_RES)/$**.png
	./make-result.sh $(TEXMF_TESTED) $< $(TESTS_RES)


