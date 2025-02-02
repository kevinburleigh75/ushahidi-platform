<?php

/**
 * UsesSiteInfo trait
 *
 * @author     Ushahidi Team <team@ushahidi.com>
 * @package    Ushahidi\Platform
 * @copyright  2014 Ushahidi
 * @license    https://www.gnu.org/licenses/agpl-3.0.html GNU Affero General Public License Version 3 (AGPL3)
 */

namespace Ushahidi\Multisite;

use Ushahidi\Multisite\Facade\Multisite;

trait UsesSiteInfo
{
    public function getSite()
    {
        return Multisite::getSite();
    }
}
