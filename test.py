import unittest
import main

class mainTest(unittest.TestCase):
    def test_setup(self):
        self.assertEqual(main(),0,'Code ok.\n')