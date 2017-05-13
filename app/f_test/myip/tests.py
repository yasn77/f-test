from django.test import TestCase


class FTestCase(TestCase):

    def test_sample_test(self):
        a = 1
        b = 2
        self.assertEqual(a + b, 3)
