import unittest
import main

class mainTest(unittest.TestCase):
    def test_setup(self):
        self.assertEqual(main(),'Successful.\n','Code ok.\n')