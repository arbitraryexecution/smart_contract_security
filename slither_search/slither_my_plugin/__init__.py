from typing import Tuple, List, Type

from slither_my_plugin.detectors.scan_functions import FunctionScanner

from slither.detectors.abstract_detector import AbstractDetector
from slither.printers.abstract_printer import AbstractPrinter


def make_plugin() -> Tuple[List[Type[AbstractDetector]], List[Type[AbstractPrinter]]]:
    plugin_detectors = [FunctionScanner]
    plugin_printers: List[Type[AbstractPrinter]] = []

    return plugin_detectors, plugin_printers
