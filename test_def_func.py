import unittest
import def_func

class def_func_testcase(unittest.TestCase):
    def test_plus(self):
        self.assertEqual(def_func.plus(2, 4), 6)

    def test_minus(self):
        self.assertEqual(def_func.minus(0, 3), -3)

    if __name__ == '__main__':
        unittest.main()
