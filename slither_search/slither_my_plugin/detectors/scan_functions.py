from slither.detectors.abstract_detector import AbstractDetector, DetectorClassification
from slither.slithir.operations import Assignment, Binary


class FunctionScanner(AbstractDetector):  # pylint: disable=too-few-public-methods
    """
    Documentation
    """

    ARGUMENT = "function-scanner"  # slither will launch the detector with slither.py --function-scanner
    HELP = "Scan contract for 'interesting' functions."
    IMPACT = DetectorClassification.LOW
    CONFIDENCE = DetectorClassification.HIGH

    WIKI = "http://www.www.www/path/to/your/wiki"
    WIKI_TITLE = "Function Scanner"
    WIKI_DESCRIPTION = "Scan contracts for 'intersting' functions"
    WIKI_EXPLOIT_SCENARIO = "Anyone who knows the interesting function can take monies."
    WIKI_RECOMMENDATION = "Consider removing functions that are *too* interestiong."

    def _show_function(self, function):
        # Slither tracks source code references
        # on relevant syntactic objects.
        src_map = function.source_mapping
        src_file = self.slither.source_code[src_map.filename.absolute]
        # We can recover the source code and
        # print it out
        return src_file[src_map.start:src_map.end]

    def _is_interesting_function(self, function):
        # We can iterate the CFG nodes of the function
        for node in function.node:
            # And the IR instructions in each node
            for ir in node.irs:
                print(ir)
        # TODO: find a condition to filter functions
        # There's something strange about all these functions,
        # No matter what we do, passwd will always be zero...
        # Is there a way to remove those operations?
        #
        # HINT: You'll probably have to use the source to understand what's in
        # the different IR operations
        # https://github.com/crytic/slither/tree/master/slither/slithir/operations
        return False

    def _detect(self):
        results = []
        # Slither can iterate over all contracts, interfaces, etc.
        # For convenience, we can iterate all functions in the compilation unit
        for function in self.compilation_unit.functions:
            if self._is_interesting_function(function):
                # Info is usually a string or array of some kind
                # Objects inheriting from "SourceMapping" will be
                # rendered with location information.
                info = [
                    function,
                    " looks interesting:\n",
                    self._show_function(function),
                    "\n"
                ]
                # Call self.generate_result to serialize
                # the detected information
                json = self.generate_result(info)
                # Each result will be reported separately by slither
                results.append(json)
        return results
