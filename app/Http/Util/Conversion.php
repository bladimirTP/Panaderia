<?php
namespace App\Http\Util;

class Conversion
{

    /**
     * @var array
     */
    protected static $conversionChart = [

        // Mass
        'MG'    => 1e-6,
        'G'     => 0.001,
        'KG'    => 1,
        'QQ50'  => 50,
        'QQ46'  => 46,
        'QQ25'  => 25,
        'OZ'    => 0.0283495,
        'LB'    => 0.453592,

        // Volume
        'ML'            => 1e-6,
        'LTS'           => 0.001,
        'CUBIC_METER'   => 1,
    ];

    /**
     * @var string
     */
    protected $value;

    /**
     * @var string
     */
    protected $unit;

    /**
     * @var
     */
    protected static $native;

    /**
     * @var null
     */
    protected $number = null;
    /**
     * @var
     */
    protected $type;

    /**
     * @param string $quantity
     * @param string $unit
     */
    public function __construct($quantity = '', $unit = '')
    {
        $this->unit = $unit;
        $this->value = $quantity;
    }

    /**
     * @param $quantity
     * @param $unit
     * @return Conversion
     */
    public static function convert($quantity, $unit)
    {
        return new Conversion($quantity, $unit);
    }

    /**
     * @param $unit
     * @return $this
     */
    public function to($unit)
    {
        $this->value = $this->process($this->unit, $unit, $this->value);
        $this->unit = $unit;

        return $this;
    }

    /**
     * @param $from
     * @param $to
     * @param $value
     * @return float
     * @throws \Exception
     */
    protected function process($from, $to, $value)
    {
        return ($value * $this->getConversion($from)) / $this->getConversion($to);
    }

    /**
     * @param $unit
     * @return mixed
     * @throws \Exception
     */
    protected function getConversion($unit)
    {
        if (!isset(static::$conversionChart[strtoupper($unit)])) {
            throw new \Exception(sprintf(
                'No conversion between "%s" and "%s" is defined.',
                static::$native,
                $unit
            ));
        }

        return static::$conversionChart[strtoupper($unit)];
    }

    /**
     * @param int $decimals
     * @param string $decPoint
     * @param string $thousandSep
     * @return string
     */
    public function format($decimals = 2, $decPoint = ',', $thousandSep = '.')
    {
        return number_format($this->value, $decimals, $decPoint, $thousandSep);
    }

    /**
     * @return string
     */
    public function __toString()
    {
        return $this->format();
    }
}